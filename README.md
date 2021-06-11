# Chrome extension upload

This action uploads the specified zipped chrome extension to the provided app id.
It uses the specified refresh token to generate an access token for uploading.

## Inputs

### `client-id`

Your tokens client id

### `client-secret`

(Required) Your tokens client secret

### `refresh-token`

(Required) Google developer refresh token

### `app-id`

(Required) The target extension id.

### `file-name`

(Required) The target zipped file name.

### `publish`

(Required) Publish or not after upload (true / false)

### `publish-target`

(Optional) Specify extension visibility > defaults to private, option 1 - default (public), option 2 - trustedTesters (private)

## Outputs

## Example usage

```
uses: adunne09/chrome-extension-upload-action
with:
  refresh-token: 'xxxxxxxxxxxxxxxxxxxxxx'
  client-id: 'xxxxxxxxxxxxx'
  client-secret: 'xxxxxxxxxxxx'
  file-name: './extension.zip'
  app-id: 'xzc12xzc21cx23'
  publish: true
  publish-target: 'default'
```
