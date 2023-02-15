# Update [Coder](https://github.com/coder/coder) Template

Update coder templates automatically

## Usage

1. Create a github secret named `CODER_SESSION_TOKEN` with your coder session token
2. create .github/workflows/ci.yml directory and file locally. Copy and paste the configuration from below, replacing the value as needed.

## Inputs

| Name | Description | Default |
| ---- | ----------- | ------- |
| `CODER_URL` | **Required** The url of coder (e.g. <https://dev.coder.com>). | - |
| `CODER_TEMPLATE_NAME` | **Required** The name of template. | - |
| `CODER_TEMPLATE_DIR` | The directory of template. |`CODER_TEMPLATE_NAME`|
| `CODER_TEMPLATE_VERSION` | The version of template. | - |
| `CODER_SESSION_TOKEN` | **Required** The session token of coder. | `secrets.CODER_SESSION_TOKEN` |

## Example

```yaml
name: Update Coder Template

on:
  push:
    branches:
      - master
    
jobs:
    update:
        runs-on: ubuntu-latest
        steps:
        - name: Checkout
          uses: actions/checkout@v3
        - name: Get latest commit hash
          id: latest_commit
          run: echo "::set-output name=hash::$(git rev-parse --short HEAD)"

        - name: Update Coder Template
            uses: matifali/update-coder-template@latest
            with:
                CODER_TEMPLATE_NAME: "my-template"
                CODER_TEMPLATE_DIR: "my-template"
                CODER_URL: "https://dev.coder.com"
                CODER_TEMPLATE_VERSION: "${{ steps.latest_commit.outputs.hash }}"
                CODER_SESSION_TOKEN: ${{ secrets.CODER_SESSION_TOKEN }}

```
