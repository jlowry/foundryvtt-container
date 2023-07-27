FROM node:lts-alpine

ARG FOUNDRY_VERSION
ADD FoundryVTT-${FOUNDRY_VERSION}.tar.xz /opt
ENTRYPOINT ["node"]
CMD ["/opt/foundryvtt/main.mjs", "--dataPath=/srv/foundrydata"]
