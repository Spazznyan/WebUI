FROM nginx:1-alpine

ENV SHOCKLINK_API_URL=https://api.shocklink.net
ENV SHOCKLINK_WEBUI_URL=https://shocklink.net/#/
ENV SHOCKLINK_SHARE_URL=https://shockl.ink/

# Copy release artifacts (static JS and CSS bundles)
COPY dist /usr/share/nginx/html

# Copy custom startup script.
# This script performs environment variable substitution!
COPY startup.sh .
RUN ["chmod", "+x", "/startup.sh"]

# Start up nginx using the alternative entrypoint, but with the default CMD.
# See: https://github.com/nginxinc/docker-nginx/blob/master/mainline/debian/Dockerfile#L113-L119
ENTRYPOINT ["/startup.sh"]
CMD ["nginx", "-g", "daemon off;"]
