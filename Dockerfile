FROM node:20.18-alpine

COPY common/deploy /deploy
WORKDIR /deploy/app

CMD ["node", "src/main.js"]
