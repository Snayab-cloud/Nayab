help:
	@printf "\033[32mRoboshop shell scripting $(version)\033[0m\n\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

common:
	@sh components/common.sh

cart: common ## Install cart component
	@sh components/cart.sh

catalogue: common ## Install catalogue component
	@sh components/catalogue.sh

frontend: common ## Install frontend component
	@sh components/frontend.sh

mongodb: common ## Install mongodb component
	@sh components/mongodb.sh

redis: common ## Install redis component
	@sh components/redis.sh

user: common ## Install user component
	@sh components/user.sh

mysql: common ## Install mysql component
	@sh components/mysql.sh

shipping: common ## Install shipping component
	@sh components/shipping.sh






