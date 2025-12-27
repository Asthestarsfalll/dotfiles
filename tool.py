import argparse
import os
import shutil

import toml

DEFAULT_SRC = "~/.config/%s"
DEFAULT_DES = "./.config/%s"


def update(config, mode="update"):
    assert mode in ["list", "update", "set"], mode
    if mode == "list":
        for k in config:
            print(k)
        return
    for name, c in config.items():
        if mode == "set" and not c.get("set", True):
            continue
        if mode == "update" and not c.get("update", True):
            continue
        src_path = os.path.expanduser(c.get("src_path", DEFAULT_SRC % name))
        des_path = os.path.expanduser(c.get("des_path", DEFAULT_DES % name))
        os.makedirs(des_path, exist_ok=True)
        backup_path = None

        if mode == "set":
            src_path, des_path = des_path, src_path
            backup_path = f"./backup/{name}"
            os.makedirs(backup_path, exist_ok=True)

        if not os.path.exists(src_path):
            print(f"Source file or folder '{src_path}' does not exist.")
            continue

        include = c.get("include", [])
        exclude = c.get("exclude", [])
        file_only = c.get("file_only", False)
        folder_only = c.get("folder_only", False)

        for item in include or os.listdir(src_path):
            if item in exclude:
                continue
            src_item_path = os.path.join(src_path, item)
            des_item_path = os.path.join(des_path, item)
            bac_item_path = os.path.join(backup_path, item) if backup_path else None

            if os.path.isfile(src_item_path) and not folder_only:
                shutil.copy2(src_item_path, des_item_path)
                assert os.path.exists(des_item_path)
                if bac_item_path:
                    shutil.copy2(src_item_path, bac_item_path)
            elif os.path.isdir(src_item_path) and not file_only:
                shutil.copytree(
                    src_item_path, des_item_path, symlinks=True, dirs_exist_ok=True
                )
                if bac_item_path:
                    shutil.copytree(
                        src_item_path, bac_item_path, symlinks=True, dirs_exist_ok=True
                    )
            print(f"Success: {src_item_path} -> {des_item_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Copy and rename a file or folder.")
    parser.add_argument("mode", help="update, set or list")
    parser.add_argument("--cfg", help="Toml config", default="./config.toml")
    parser.add_argument("--target", help="Select", default=None)
    parser.add_argument("--force", default=None)

    args = parser.parse_args()

    cfg = toml.load(args.cfg)

    if args.target is not None:
        assert args.target in cfg
        cfg = {args.target: cfg[args.target]}
        if args.force:
            cfg[args.target]["update"] = True
            cfg[args.target]["set"] = True

    update(cfg, args.mode)
