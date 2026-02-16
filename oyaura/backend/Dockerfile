FROM node:18-alpine

WORKDIR /usr/src/app

# Install app dependencies
COPY package.json package-lock.json* ./
RUN npm install --production

# Bundle app source
COPY . .

EXPOSE 4000

CMD ["npm", "start"]
