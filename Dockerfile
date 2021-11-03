FROM node:latest as build-deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
ARG ENDPOINT
ENV NODE_GRAPHQL_ENDPOINT=${ENDPOINT}
RUN yarn prod:build && mv ./static/* dist/

FROM nginx:latest
COPY --from=build-deps /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
