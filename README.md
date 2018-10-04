# Identicon
An identicon is a visual representation of a hash value. This application takes in a string and then converts it to a md5 hash value. From that value the application runs an algorithm to generate a unique image.

## Version Information
```
app: :identicon,
version: "0.1.0",
elixir: "~> 1.7",
```

## Install elixir
> https://elixir-lang.org/install.html

## How to test
```
mix test
```

## How to view documentation
Documentation can be generated using
```
mix docs
```
> Documentation, after generation can be found by opening `doc/index.html`

## How to run
```
mix deps.get
iex -S mix
Identicon.transformation("name")
```

> New images by default are saved to the `images` folder.

## Examples
---
<div align=center>

### **codingdracula** <br> <br>
![codingdracula](images/codingdracula.png)
<br> <br>
### **foobar** <br> <br>
![foobar](images/foobar.png)
<br><br>
### **identicon**
![identicon](images/identicon.png)

</div>
