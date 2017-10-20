system-reload:
	make nginx-reload
	make service-reload

service-reload:
	cd private_isu/webapp/ruby
	(cd /home/isucon/private_isu/webapp/ruby; bundle install)
	sudo systemctl restart isu-ruby.service
	cd

nginx-reload:
	sudo nginx -s reload

deploy:
	git pull
	make system-reload

db_up:
	/home/isucon/go/bin/goose up

db_down:
	/home/isucon/go/bin/goose down

db_status:
	/home/isucon/go/bin/goose status

