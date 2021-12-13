FROM ubuntu:latest

COPY . ./root/.dotfiles

WORKDIR /root

# CMD [ "~/.dotfiles/install1.sh" ]
