FROM node:lts as builder
ARG FOUNDRY_VERSION
COPY FoundryVTT-${FOUNDRY_VERSION}.tar.xz .
RUN tar xJf FoundryVTT-${FOUNDRY_VERSION}.tar.xz -C /opt

FROM node:lts-alpine
ARG FOUNDRY_VERSION
ARG FOUNDRY_UID=421
COPY --from=builder /opt/foundryvtt /opt/foundryvtt

RUN addgroup -S -g ${FOUNDRY_UID} foundry \
    && adduser -S -h /var/foundryvtt -H -s /bin/false -D -G ${FOUNDRY_UID} -u ${FOUNDRY_UID} foundry

USER foundry
ENTRYPOINT ["node"]
CMD ["/opt/foundryvtt/main.mjs", "--dataPath=/srv/foundrydata"]
