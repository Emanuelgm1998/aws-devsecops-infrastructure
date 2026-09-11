FROM node:24-alpine

WORKDIR /app

COPY package.json .
COPY index.js .

RUN npm install -g npm@11.18.0

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]
