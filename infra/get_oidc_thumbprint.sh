#!/bin/bash

# Usage: ./get_oidc_thumbprint.sh <region> <oidc_endpoint_without_protocol>
# Example: ./get_oidc_thumbprint.sh us-west-2 oidc.eks.us-west-2.amazonaws.com

REGION=$1
OIDC_ENDPOINT=$2

#CERTIFICATE=$(echo | openssl s_client -showcerts -servername $OIDC_ENDPOINT -connect $OIDC_ENDPOINT:443 2>/dev/null | openssl x509 -inform pem -noout -fingerprint -sha1 | sed 's/SHA1 Fingerprint=//' | sed 's/://g')
CERTIFICATE=$(echo | openssl s_client -showcerts -servername "$OIDC_ENDPOINT" -connect "$OIDC_ENDPOINT:443" 2>/dev/null | openssl x509 -inform pem -noout -fingerprint -sha1 | sed 's/^.*Fingerprint=//' | tr -d ':')

echo "{\"thumbprint\":\"$CERTIFICATE\"}"
