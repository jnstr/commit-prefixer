# Commit prefixer

This is the convention I use to give extra context to my commits

## Why?

I really love the idea behind [gitmoji](https://gitmoji.carloscuesta.me/), it allows you give extra context to your commit message with only one character, and it forces you to create small commits.

However, gitmoji has some drawbacks:
- It has way too many categories, which makes it hard to remember
- It is too colorful. I like my prefixes like my soul: black
- It felt a bit childish at times

That's why created my own set of git commit prefix icons. Just one character, and only a limited set.

## Installation

1. Clone this repository
2. cd into the project directory
3. `chmod +x prefixer.sh`
4. `ln -s "$(pwd)/prefixer.sh" /usr/local/bin/commit`

_Note: I just aliased this to `commit` but you can use whatever suits you best_

## Usage

Siply run `commit` (or whatever alias you chose) and you are prompted for the commit type.

```shell
> commit
Please enter your commit type: 
1) [+] Adding a file or feature            5) [L] Fixing linter errors & warnings
2) [B] Fixing a bug                        6) [R] Refactoring existing code
3) [-] Removing code or files              7) [T] Adding or updating tests
4) [M] Moving or renaming files            8) [!] Bad code that needs to be improved
#? 
```

Enter the number of the option you want, and the commit is prefixed with your type (and JIRA issue if applicable)

### Add the JIRA issue

The JIRA issue is automatically extracted from the branch if it follows the guidelines:  
The part after the last `/` needs to start with the issue number.

For example the `JNSTR-123` story works with these branches:
- `JNSTR-123-do-something-special`
- `feature/JNSTR-123-do-something-special`
- `feature/something/jnstr-123-do-something-special`

_note: the project prefix should be between 2 and 5 characters. Other lengths aren't supported_

The commit prefix for a new feature will then look like this:  
`[F][JNSTR-123]`

### The commit template file

There is a temporary commit template file created where the prefix is stored: `.commit-template`.  
You could add this to your global gitignore file in order to never see it in git (it should be removed after every commit but you never know when something goes wrong).

## The list

### `[+]`: Adding a file or feature

_example: `[+] Add .gitignore`_

### `[B]` Fixing a bug

_example: `[B] Make it load in Internet Explorer`_

### `[-]`: Removing code or files

_example: `[-] Remove unused method`_

### `[M]`: Moving or renaming files

_example: `[M] Give it a more appropriate name`_

### `[L]`: Fixing linter errors & warnings

_example: `[L] Fix linting errors`_

### `[R]`: Refactoring existing code

_example: `[R] Split up into multiple methods`_

### `[T]`: Adding or updating tests

_example: `[T] Prove bug with a test`_

### `[!]`: Bad code that needs to be improved

_example: `[!] Hard-code these values for now`_

## Note

This list is mostly meant for personal reference, I do not intend to convince people to use this list.  
