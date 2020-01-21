FROM bash AS build

COPY c5 /tmp/
COPY c5.bat /tmp/
COPY composerpkg /tmp/
COPY composerpkg.bat /tmp/

RUN \
    chmod 0755 /tmp/c5 /tmp/composerpkg && \
    chmod 0555 /tmp/c5.bat /tmp/composerpkg.bat

FROM scratch

COPY --from=build /tmp/c5 /usr/bin/
COPY --from=build /tmp/composerpkg /usr/bin/
COPY --from=build /tmp/c5.bat /usr/bin/
COPY --from=build /tmp/composerpkg.bat /usr/bin/
