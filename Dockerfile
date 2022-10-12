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


## 이거 안될듯. 왜냐면 node도 서버고 nginx도 서버니까 컨테이너 따로 빼야할듯.... 아니면 eb설정 바꾸던지
# FROM nginx
# EXPOSE 8080
# COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf