FROM node:19-alpine as base
#confirmed
RUN apk add cairo-dev pango-dev jpeg-dev giflib-dev freetype-dev
#maybe
RUN apk add freetype
#maybe
RUN apk add --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing libmount ttf-dejavu
# ttf-liberation fontconfig
RUN npm install -g pnpm

ADD package.json pnpm-lock.yaml /app/
WORKDIR /app

FROM base as build-deps
RUN apk add git python3 pkgconfig libc6-compat build-base g++
RUN pnpm install -P

FROM base as build-app
COPY --from=build-deps /app/node_modules /app/node_modules
ADD tsconfig.json /app/
ADD src /app/src
RUN pnpm install
RUN pnpm run build

FROM base
COPY --from=build-deps /app/node_modules /app/node_modules
COPY --from=build-app /app/dist /app/dist

ENV PORT=80
CMD node dist/index
