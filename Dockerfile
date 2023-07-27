FROM node:lts as builder
ARG FOUNDRY_VERSION
COPY FoundryVTT-${FOUNDRY_VERSION}.tar.xz .
RUN tar xJf FoundryVTT-${FOUNDRY_VERSION}.tar.xz -C /opt

FROM node:lts-alpine
ARG FOUNDRY_VERSION
ARG FOUNDRY_UID=421
COPY --from=builder /opt/foundryvtt /opt/foundryvtt

RUN groupadd --gid ${FOUNDRY_UID} foundry \
    && useradd --system --home-dir /var/foundryvtt --shell /bin/false --gid ${FOUNDRY_UID}

ENTRYPOINT ["node"]
CMD ["/opt/foundryvtt/main.mjs", "--dataPath=/srv/foundrydata"]
