#!/bin/sh

set -e

echo get token
token=`curl \
--silent \
--fail \
-H "Content-Type: application/json" \
-d '{
	"refresh_token": "'$1'",
	"client_id": "'$2'",
	"client_secret": "'$3'",
	"grant_type": "refresh_token"
}' \
-X POST \
-v https://www.googleapis.com/oauth2/v4/token \
| \
jq -r '.access_token'`

echo upload file
status=`curl \
--silent \
--show-error \
--fail \
-H "Authorization: Bearer $token" \
-H "x-goog-api-version: 2" \
-X PUT \
-T $4 \
-v https://www.googleapis.com/upload/chromewebstore/v1.1/items/$5 \
| tee status.json | jq -r '.uploadState'`

if [ $status == 'FAILURE' ]
then
  exit 1
fi

if [ $6 == true ] #publish
then
  echo publish
  publish=`curl \
  --silent \
  --show-error \
  --fail \
  -H "Authorization: Bearer $token" \
  -H "x-goog-api-version: 2" \
  -X POST \
  -v https://www.googleapis.com/chromewebstore/v1.1/items/$5/publish \
  -d publishTarget="$7" \
  | tee publish.json | jq -r '.publishState'` 

  if [ $publish == 'FAILURE' ]
  then
    exit 1
  fi
fi

exit 0
