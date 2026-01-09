[private]
default:
	@just --list

# Deploy the current state of the dotfiles
deploy:
    @./dotter deploy
        
# Edit the cached symlinks and templates
cache:
    @$EDITOR .dotter/cache.toml
