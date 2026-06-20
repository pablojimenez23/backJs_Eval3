# ---- STAGE 1: Build ----
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# ---- STAGE 2: Producción ----
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js .
COPY package*.json ./
ENV PORT=8081
EXPOSE 8081
CMD ["node", "server.js"]