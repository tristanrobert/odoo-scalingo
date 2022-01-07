FROM scalingo/scalingo-18

ADD . buildpack
RUN ls -a buildpack/
ADD .env /env/.env
RUN buildpack/bin/env.sh /env/.env /env
ADD .buildpacks /build/.buildpacks
ADD Aptfile /build/Aptfile
RUN git clone https://github.com/Scalingo/multi-buildpack
RUN BUILDPACK_DEBUG=true multi-buildpack/bin/compile /build /cache /env
RUN rm -rf /app/*.*
RUN cp -a /build/. /app
RUN ls -a /app
RUN chmod +x /app/.profile.d/000_apt.sh
RUN /app/.profile.d/000_apt.sh

EXPOSE ${PORT}

ENTRYPOINT [ "/app/bin/run" ]