# b-html-cli

A CLI for [b-html](https://github.com/b-html/b-html).

## Installation

```
$ npm install -g b-html-cli
```

## Usage

### `index.bhtml` -> `index.html`

```
$ b-html index.bhtml
```

### `bhtmls/**/*.bhtml` -> `htmls/**/*.html`

```
$ b-html -o htmls/ bhtmls/
```

### `index.bhtml` <- `index.html`

```
$ b-html -m h2b index.html
```

or

```
# -s is "remove white spaces" option.
# (You might get the result you want!)
$ b-html -m h2b -s index.html
```

### `bhtmls/**/*.bhtml` <- `htmls/**/*.html`

```
$ b-html -m h2b -o bhtmls/ htmls/
```

or

```
# -s is "remove white spaces" option.
# (You might get the result you want!)
$ b-html -m h2b -s -o bhtmls/ htmls/
```

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][email]&gt; ([http://bouzuya.net][url])

[user]: https://github.com/bouzuya
[email]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
