# プロジェクトファイルに
# Link Binary With Librariesが残り続けるバグが起きたら実行する
# 例：python fix_project_file.py 03_Complete/MultiModuleTodo.xcodeproj/project.pbxproj

import re
import argparse
import os
import sys

def fix_project_file(project_path):
    if not os.path.exists(project_path):
        print(f"Error: File not found at {project_path}")
        sys.exit(1)

    print(f"Processing: {project_path}")

    with open(project_path, 'r') as f:
        content = f.read()

    # 1. Clear packageProductDependencies in PBXNativeTarget
    # Matches: packageProductDependencies = ( ... );
    # Replaces with: packageProductDependencies = (\n\t\t\t);
    content = re.sub(
        r'(packageProductDependencies\s*=\s*\()([\s\S]*?)(\);)',
        r'\1\n\t\t\t\3',
        content
    )

    # 2. Clear XCSwiftPackageProductDependency section
    # Matches everything between Begin and End markers
    # We want to keep the markers but remove the content.
    content = re.sub(
        r'(/\* Begin XCSwiftPackageProductDependency section \*/)([\s\S]*?)(/\* End XCSwiftPackageProductDependency section \*/)',
        r'\1\n\3',
        content
    )

    with open(project_path, 'w') as f:
        f.write(content)

    print(f"Successfully cleaned {project_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Remove stale package dependencies from project.pbxproj')
    parser.add_argument('project_path', help='Path to the project.pbxproj file')
    
    args = parser.parse_args()
    fix_project_file(args.project_path)