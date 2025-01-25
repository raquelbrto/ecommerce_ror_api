FROM ruby:3.2.1

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Define o diretório de trabalho
WORKDIR /app

# Instala as gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copia o código do aplicativo
COPY . .

# Exponha a porta da aplicação
EXPOSE 3001