FROM node:20-alpine

WORKDIR /app

COPY package.json .
COPY index.js .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]
