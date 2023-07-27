ARG FOUNDRY_VERSION

FROM node:lts as builder
COPY FoundryVTT-${FOUNDRY_VERSION}.tar.xz .
RUN tar xJf FoundryVTT-${FOUNDRY_VERSION}.tar.xz /opt

FROM node:lts-alpine
COPY --from=builder /opt/foundryvtt /opt/foundryvtt
ENTRYPOINT ["node"]
CMD ["/opt/foundryvtt/main.mjs", "--dataPath=/srv/foundrydata"]
