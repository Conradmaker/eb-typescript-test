# Builder stage.
FROM node:16-alpine as builder
WORKDIR /usr/src/app
COPY ./package.json ./
COPY ./yarn.lock ./
COPY ./tsconfig.json ./
# RUN npm install

COPY ./src ./src
ENV NODE_ENV production
RUN yarn install --frozen-lockfile --production && yarn build


# Production stage.
FROM node:16-alpine
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=8080
COPY package.json ./
COPY ./yarn.lock ./
COPY ./ecosystem.config.js ./
COPY ./docker-compose.yml ./
COPY ./Dockerfile ./
RUN yarn install --frozen-lockfile --production
COPY --from=builder /usr/src/app/build ./build
RUN ls -a

RUN yarn global add pm2
# RUN ls -a

CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]

