FROM node:lts as builder
ARG FOUNDRY_VERSION
COPY FoundryVTT-${FOUNDRY_VERSION}.tar.xz .
RUN tar xJf FoundryVTT-${FOUNDRY_VERSION}.tar.xz /opt

FROM node:lts-alpine
ARG FOUNDRY_VERSION
COPY --from=builder /opt/foundryvtt /opt/foundryvtt
ENTRYPOINT ["node"]
CMD ["/opt/foundryvtt/main.mjs", "--dataPath=/srv/foundrydata"]
