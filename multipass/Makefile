cloud-config.out.yml: cloud-config.yml
	./process.sh "$<" "$@"

up: cloud-config.out.yml
	multipass launch noble \
		-v \
		-n weebify \
		--cpus 2 \
		--disk 12G \
		--memory 6G \
		--timeout 1800 \
		--network name=weeb,mode=manual \
		--cloud-init cloud-config.out.yml

shell:
	multipass shell weebify

remove:
	multipass delete weebify --purge || true

clean:
	rm -f cloud-config.out.yml

recreate: remove cloud-config.out.yml up

.PHONY: up shell remove clean recreate
