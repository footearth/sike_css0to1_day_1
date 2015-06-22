{
  log
  error
} = console

gulp = require 'gulp'
gulpFilter = require 'gulp-filter'

plumber = require 'gulp-plumber'

jade = require 'gulp-jade'
less = require 'gulp-less'

tap = require 'gulp-tap'
watch = require 'gulp-watch'
browserSync = require 'browser-sync'

module.exports = ->

  jadeFilter = gulpFilter ['**/*.jade']
  lessFilter = gulpFilter ['**/*.less']

  gulp.src [
    'src/**/*'
  ]

  .pipe plumber
    errorHandler: (err) ->
      error err
      @emit 'end'

  # jade
  .pipe jadeFilter
  .pipe jade
    pretty: true
    locals: {}
  .pipe jadeFilter.restore()

  # stylus
  .pipe lessFilter
  .pipe less()
  .pipe lessFilter.restore()

  # browserSync
  .pipe browserSync.reload stream:true

  .pipe plumber.stop()

  # dest
  .pipe gulp.dest 'build'
