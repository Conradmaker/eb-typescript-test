# Builder stage.
FROM node:16-alpine as builder
WORKDIR /usr/src/app
COPY ./package.json ./
COPY ./yarn.lock ./
COPY ./tsconfig.json ./
# RUN npm install

COPY ./src ./src
ENV NODE_ENV production
RUN yarn install --frozen-lockfile && yarn build


# Production stage.
FROM node:16-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY package.json ./
COPY ./yarn.lock ./
RUN yarn install --frozen-lockfile --production
RUN ls -a
COPY --from=builder /usr/src/app/build ./build

RUN yarn global add pm2
COPY ./ecosystem.config.js ./
# RUN ls -a
CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]