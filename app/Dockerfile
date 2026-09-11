FROM node:24-alpine

WORKDIR /app

COPY package.json .
COPY index.js .

RUN apk upgrade --no-cache
RUN npm install -g npm@12.0.2

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]
