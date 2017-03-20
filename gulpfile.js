var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    stylus = require('gulp-stylus'),
    pug = require('gulp-pug'),
    concat = require('gulp-concat'),
    inject = require('gulp-inject'),
    del = require('del');

gulp.task('clean', function() {
    return del.sync('dist');
});

gulp.task('coffee', function() {
    return gulp.src(['./app/functionality/**/*.coffee', './app/main.coffee', './app/scripts/*.coffee'])
        .pipe(coffee())
        .pipe(concat('script.js'))
        .pipe(gulp.dest('./dist/script/'));
});

gulp.task('stylus', function() {
    return gulp.src(['./app/**/*.css', './app/**/*.styl'])
        .pipe(stylus())
        .pipe(concat('style.css'))
        .pipe(gulp.dest('./dist/style/'));
});

gulp.task('pug', function() {
    return gulp.src('./app/index.pug')
        .pipe(pug({
            pretty: true
        }))
        .pipe(gulp.dest('./dist/'));
});

gulp.task('font', function() {
    return gulp.src('./app/style/fonts/*.*')
        .pipe(gulp.dest('./dist/fonts/'));
});

gulp.task('images', function() {
    return gulp.src('./app/images/**/*.*')
        .pipe(gulp.dest('./dist/images/'));
});

gulp.task('jsons', function() {
    return gulp.src(['./app/functionality/history/*.json', './app/layout/text/*.json'])
        .pipe(gulp.dest('./dist/jsons/'));
});

gulp.task('build-project', ['clean', 'jsons', 'coffee', 'stylus', 'pug', 'font', 'images'], function (){
    console.log('Building files');
})