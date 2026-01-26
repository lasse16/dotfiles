[private]
default:
	@just --list

# Deploy the current state of the dotfiles
deploy:
    @./dotter deploy
        
# Edit the cached symlinks and templates
cache:
    @$EDITOR .dotter/cache.toml

# Edit the Dotter local configuration
config:
    @$EDITOR .dotter/local.toml

# Edit the Dotter local configuration
global:
    @$EDITOR .dotter/global.toml
