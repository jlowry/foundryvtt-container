FROM node:lts as builder
RUN /usr/bin/curl -L -o foundryvtt.zip $TIMED_URL; \
    unzip foundryvtt.zip resources/*; \
    mv resources/app foundryvtt

FROM node:lts
COPY --from=builder /root/foundryvtt /opt/
RUN ls -la /opt/
ENTRYPOINT node
CMD /opt/foundryvtt/main.js --dataPath=/srv/foundrydata




