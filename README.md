Cinemastar
=====================================================

Cinemastar is home video server

Requirements
-----------------------------------------------------

* Ruby 1.9.3
* Sinatra
* FFmpeg


Getting Started
-----------------------------------------------------

Install FFmpeg by the Homebrew

```sh
$ brew install ffmpeg
```

Install the bundler

```sh
$ gem install bundler
```

Install rubygems

```sh
$ git clone https://github.com/naoto/cinemastar.git
$ cd cinemastar
$ bundle install --path vendor/bundle
```


Setting
-----------------------------------------------------

### Write config/setting.yaml

```yaml
---
:movie_directory: /path/to/movie/directory
```


Start
------------------------------------------------------

```sh
$ bundle exec bin/cinemastar
```

