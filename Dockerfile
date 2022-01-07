FROM scalingo/scalingo-18

ADD . buildpack
ADD .env /env/.env
RUN buildpack/bin/env.sh /env/.env /env
ADD .buildpacks /build/.buildpacks
ADD Aptfile /build/Aptfile
RUN git clone https://github.com/Scalingo/multi-buildpack
RUN BUILDPACK_DEBUG=true multi-buildpack/bin/compile /build /cache /env
RUN rm -rf /app/*.*
RUN cp -a /build/. /app

EXPOSE ${PORT}

ENTRYPOINT [ "/app/bin/run" ]