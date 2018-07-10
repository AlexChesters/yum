(async () => {
  const fs = require('fs')
  const octokit = require('@octokit/rest')()

  const secretToken = process.argv[2]

  octokit.authenticate({ type: 'token', token: secretToken })

  let lastVersion = -1

  try {
    const latestReleaseData = await octokit.repos.getLatestRelease({
      owner: 'alexchesters',
      repo: 'utils'
    })
    lastVersion = parseInt(latestReleaseData.data.tag_name)
  } catch (ex) {
    console.error('[ERROR] error getting last release, setting version to be 0')
  }

  const result = await octokit.repos.createRelease({
    owner: 'alexchesters',
    repo: 'utils',
    tag_name: (lastVersion + 1).toString()
  })

  const data = fs.readFileSync('./RPMS/x86_64/alexchesters-utils-0.0.0-1.x86_64.rpm')

  await octokit.repos.uploadAsset({
    url: result.data.upload_url,
    file: Buffer.from(data),
    contentType: 'application/x-rpm',
    contentLength: Buffer.byteLength(data),
    name: 'alexchesters-utils.rpm'
  })
})()
