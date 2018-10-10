if [[ ! -z "${PUBLIC_DOMAIN_NAME}" ]]; then
    if [[ ${NGINX_PORT} != "" && ${NGINX_PORT} != "80" ]]; then
        PUBLIC_PORT=":${NGINX_PORT}"
    else
        PUBLIC_PORT=""
    fi
    export ENKETO_URL="${PUBLIC_REQUEST_SCHEME}://${ENKETO_EXPRESS_PUBLIC_SUBDOMAIN}.${PUBLIC_DOMAIN_NAME}${PUBLIC_PORT}"
    export ENKETO_INTERNAL_URL="http://${ENKETO_EXPRESS_PUBLIC_SUBDOMAIN}.${INTERNAL_DOMAIN_NAME}" # Always use HTTP internally.
    export KOBOCAT_URL="${PUBLIC_REQUEST_SCHEME}://${KOBOCAT_PUBLIC_SUBDOMAIN}.${PUBLIC_DOMAIN_NAME}${PUBLIC_PORT}"
    export KOBOCAT_INTERNAL_URL="http://${KOBOCAT_PUBLIC_SUBDOMAIN}.${INTERNAL_DOMAIN_NAME}" # Always use HTTP internally.
    export CSRF_COOKIE_DOMAIN=".${PUBLIC_DOMAIN_NAME}"
    export DJANGO_ALLOWED_HOSTS=".${PUBLIC_DOMAIN_NAME} .${INTERNAL_DOMAIN_NAME}"

elif [[ ! -z "${HOST_ADDRESS}" ]]; then
    # Local configuration
    export ENKETO_URL="http://${HOST_ADDRESS}:${ENKETO_EXPRESS_PUBLIC_PORT}"
    export KOBOCAT_URL="http://${HOST_ADDRESS}:${KOBOCAT_PUBLIC_PORT}"
    export KOBOCAT_INTERNAL_URL="${KOBOCAT_URL}" # FIXME: Use an actual internal URL.
    export CSRF_COOKIE_DOMAIN="${HOST_ADDRESS}"
    export DJANGO_ALLOWED_HOSTS='*'
else
    echo 'Please fill out your `envfile`!'
    exit 1
fi

export DJANGO_DEBUG="${KPI_DJANGO_DEBUG}"
export RAVEN_DSN="${KPI_RAVEN_DSN}"
export RAVEN_JS_DSN="${KPI_RAVEN_JS_DSN}"
