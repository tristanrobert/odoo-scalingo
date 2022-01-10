FROM scalingo/scalingo-20

ADD . buildpack
ADD .env /env/.env
RUN buildpack/bin/env.sh /env/.env /env
ADD .buildpacks /build/.buildpacks
ADD Aptfile /build/Aptfile
ADD runtime.txt /build/runtime.txt
RUN git clone https://github.com/Scalingo/multi-buildpack
RUN multi-buildpack/bin/compile /build /cache /env
RUN echo "$PYTHONPATH"
RUN rm -rf /app/*
RUN rsync -av build/ app/ --exclude=".scalingo"
WORKDIR /app

EXPOSE ${PORT}

ENTRYPOINT [ "/app/bin/run" ]