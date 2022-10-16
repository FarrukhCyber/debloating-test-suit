## How to use?
Place the train file in the nginx source code directory. Make sure you run the configure command with the following modules before running the train script
```
./configure --prefix=/var/www/html --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --with-pcre  --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-http_image_filter_module=dynamic --modules-path=/etc/nginx/modules --with-http_v2_module --with-stream=dynamic --with-http_addition_module --with-http_mp4_module
```
While debloating if you receive an error "No Makefile found," it's becuase the make clean command removes the Makefiles so you have to configure again. Another way is to change your clean function in the Makefile of source directory.
Change 
```
clean:
  rm -rf Makefile objs
```

to this:

```
clean:
  rm -rf ./objs/*.o ./objs/*.so ./objs/nginx ./objs/nginx.8
```
