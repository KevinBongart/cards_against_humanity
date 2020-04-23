# Unofficial Cards Against Humanity, Online

An unofficial online version of the Cards Against Humanity game. Pairs well with friends, booze and video chat.

[Click here to play](https://www.cardsagainsthumanity.online).

Put together by [Kevin Bongart](http://kevinbongart.net) so he could play his beloved game with friends during tough times. Not affiliated with the official [Cards Against Humanity](https://cardsagainsthumanity.com/) company, but you should absolutely [buy their game](https://store.cardsagainsthumanity.com/) because it's a lot more fun in person. Remixed under [Creative Commons BY-NC-SA 2.0 license](https://creativecommons.org/licenses/by-nc-sa/2.0/).

The cards were imported from [json-against-humanity](https://github.com/crhallberg/json-against-humanity).

## Development setup

This is a Ruby on Rails application that requires Ruby, PostgreSQL and Redis.

1. Install Ruby, preferrably with [`rbenv`](https://github.com/rbenv/rbenv)
2. Install dependencies:

```sh
$ gem install bundler
$ bundle install
$ yarn install
```

3. Create, migrate and populate the database:

```sh
$ bundle exec rails db:create db:migrate db:seed
```

4. Start the web server and the background job processor:

```sh
$ bundle exec rails server
$ bundle exec sidekiq
```

Streaming game updates to clients goes through background jobs, so Sidekiq is required (otherwise, players need to refresh the page manually).

Alternatively, you can use an application process manager to start both the web server and background job processor. [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) is a good Ruby-based option, but there are many alternatives to suit your needs:

```sh
$ gem install foreman
$ foreman start web=1,worker=1
```

5. Open a browser to [http://localhost:3000](http://localhost:3000)

## Running the test suite

```sh
bundle exec rspec
```
