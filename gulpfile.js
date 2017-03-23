var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    stylus = require('gulp-stylus'),
    pug = require('gulp-pug'),
    concat = require('gulp-concat'),
    inject = require('gulp-inject'),
    del = require('del'),
    zip = require('gulp-zip');

gulp.task('clean', function() {
    return del.sync(['dist.zip', 'dist']);
});

gulp.task('coffee', function() {
    return gulp.src(['./app/scripts/classes/*.coffee', './app/functionality/**/*.coffee', './app/main.coffee', './app/scripts/*.coffee'])
        .pipe(concat('script.js'))
        .pipe(coffee())
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

gulp.task('build', ['clean', 'jsons', 'coffee', 'stylus', 'pug', 'font', 'images'], function (){
});

gulp.task('build-project', ['build'], function (){
    return gulp.src('dist/**')
        .pipe(zip('dist.zip'))
        .pipe(gulp.dest('./'))
});