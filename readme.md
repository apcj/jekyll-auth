# Jekyll Google Auth

*A simple way to use Google OAuth2 to serve a protected jekyll site to users within an email domain*

**NOTE: This repo is a fork of [benbalter/jekyll-auth](https://github.com/benbalter/jekyll-auth), with GitHub replaced by Google OAuth2, using
[apcj/sinatra-google-auth](https://github.com/apcj/sinatra-google-auth) (forked from [csquared/sinatra-google-auth](https://github.com/csquared/sinatra-google-auth)) and [zquestz/omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2).**

## The problem

[Jekyll](http://github.com/mojombo/jekyll) and [GitHub Pages](http://pages.github.com) are awesome, right? Static site, lightning fast, everything versioned in Git. What else could you ask for?

But what if you only want to share that site with people in your company? Before, you were SOL. Now, simply host the site on a free, [Heroku](http://heroku.com) Dyno, and whenever someone tries to access it, it will oauth them against Google, and make sure their username has the right domain. Pretty cool, huh?

## Requirements

1. You trust that people with a google account matching your domain are really members
   of your organisation, and therefore should be able to see the site.
2. A Google Application (You can always [register one](https://console.developers.google.com/project) for free)
3. A heroku account

## Getting Started

### Create a Google Application

Follow instructions at [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2#google-api-setup).

### Add Jekyll Auth to your site

First, add `gem 'nexaas-jekyll-google-auth'` to your `Gemfile` or if you don't already have a `Gemfile`, create a file called `Gemfile` in the root of your site's repository with the following content:

```
source "https://rubygems.org"

gem 'nexaasa-jekyll-google-auth'
```

Next, `cd` into your project's directory and run `bundle install`.

Finally, run `jekyll-auth new` which will run you through everything you need to set up your site with Jekyll Auth.

### Whitelisting

Don't want to require authentication for every part of your site? Fine! Add a whitelist to your Jekyll's *_config.yml_* file:

```yaml
jekyll_auth:
  whitelist:
    - drafts?
```

`jekyll_auth.whitelist` takes an array of regular expressions as strings. The default auth behavior checks (and blocks) against root (`/`). Any path defined in the whitelist won't require authentication on your site.

What if you want to go the other way, and unauthenticate the entire site _except_ for certain portions? You can define some regex magic for that:

```yaml
jekyll_auth:
  whitelist:
    - "^((?!draft).)*$"
```

## Requiring SSL

If [you've got SSL set up](https://devcenter.heroku.com/articles/ssl-endpoint), simply add the following your your `_config.yml` file to ensure SSL is enforced.

```yaml
jekyll_auth:
  ssl: true
```

## Running locally

Want to run it locally?

### Without authentication

Just run `jekyll serve` as you would normally

### With authentication

1. `export GOOGLE_CLIENT_ID=[your Google app client id]`
2. `export GOOGLE_CLIENT_SECRET=[your Google app client secret]`
3. `export GOOGLE_EMAIL_DOMAIN=[email domain]`
4. `jekyll-auth serve`

*Pro-tip #1:* For sanity sake, and to avoid problems with your callback URL, you may want to have two apps, one with a local oauth callback, and one for production if you're going to be testing auth locally.

*Pro-tip #2*: Jekyll Auth supports [dotenv](https://github.com/bkeepers/dotenv) out of the box. You can create a `.env` file in the root of site and add your configuration variables there. It's ignored by `.gitignore` if you use `jekyll-auth new`, but be sure not to accidentally commit your `.env` file. Here's what your `.env` file might look like:

```
GOOGLE_CLIENT_SECRET=abcdefghijklmnopqrstuvwxyz0123456789
GOOGLE_CLIENT_ID=qwertyuiop0001
GOOGLE_EMAIL_DOMAIN=example.com
```

## Under the hood

Every time you push to Heroku, we take advantage of the fact that Heroku
automatically runs the `rake assets:precompile` command (normally used
for Rails sites) to build our Jekyll site and store it statically,
just like GitHub pages would.

Anytime a request comes in for a page, we run it through
[Sinatra](http://www.sinatrarb.com/) (using the `_site` folder as the static
file folder, just as `public` would be normally), and authenticate it using [apcj/sinatra-google-auth](https://github.com/apcj/sinatra-google-auth).

If they have the correct, they get the page. Otherwise, all they get bounced
back to Google, where they might be able to log in with an appropriate user.
