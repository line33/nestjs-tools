#!/bin/bash
# Created by Amadi Ifeanyi <helloamadiify@gmail.com>
# This works with SOLID architecture
echo "What would you like to create?"

echo "1. Module"
echo "2. Controller"
echo "3. Dto"
echo "4. Schema"
echo "5. Service"
echo ""
echo "Please enter a number:"

read create_option

# Create Vars
modules=1
controllers=2
dto=3
schema=4
services=5
dir=$(pwd)

# create module
if [ "$create_option" -eq "$modules" ]
then
    echo "Enter module folder name:"
    read module_name

    new_dir="$dir/src/modules/$module_name"

    echo "Enter module class name:"
    read module_class_name

    # only create if folder does not exists
    if [ ! -d "$new_dir" ]
    then 
        # Create folder
        mkdir "$new_dir"

        # Create required folders
        mkdir "$new_dir/controllers"
        mkdir "$new_dir/dtos"
        mkdir "$new_dir/models"
        mkdir "$new_dir/services"
        mkdir "$new_dir/tests"
        mkdir "$new_dir/common"

        # create template
        module=$(printf "import { Module } from '@nestjs/common';\nimport { ${module_class_name}Controller } from './controllers/${module_name}.controller';\n@Module({\n\timports:[],\n\tproviders:[],\n\tcontrollers:[${module_class_name}Controller]\n})\nexport class ${module_class_name}Module {}\n")

        # Create required files
        echo "$module" > "$new_dir/$module_name.module.ts"

        # create template
        controller=$(printf "import { Controller, Get, Post, Put, Patch, Delete } from '@nestjs/common';\nimport { ${module_class_name}Service } from '../services/${module_name}.service';\n\n@Controller()\nexport class ${module_class_name}Controller {}")
        echo "$controller" > "$new_dir/controllers/$module_name.controller.ts"

        # create model
        # model=$(printf "import mongoose, { HydratedDocument } from 'mongoose'\nimport { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';\n\nexport type ${module_name}Document = HydratedDocument<${module_name}Model>;\n\n@Schema()\nexport class ${module_name}Model {\n\n}\n\nexport const ${module_name}Schema = SchemaFactory.createForClass(${module_name}Model);\n")
        echo "" > "$new_dir/models/$module_name.model.ts"

        # create template
        service=$(printf "import { Injectable } from '@nestjs/common';\n\n@Injectable()\nexport class ${module_class_name}Service {}")
        echo "$service" > "$new_dir/services/$module_name.service.ts"

        # create readme
        echo "# ${module_name} Developer Documentation" > "$new_dir/readme.md"

        # all good and created 
        echo "${module_name} Module created successfully"

    else
        echo "$module_name already exists!"
        exit 0
    fi

fi

# create schema/model
if [ "$create_option" -eq "$schema" ]
then
    echo "Enter Schema file name:"
    read schema_file_name

    schema_file="$dir/src/database/$schema_file_name.schema.ts"

    echo "Enter Schema class name:"
    read schema_name

    # only create if file does not exists
    if [ ! -f "$schema_file" ]
    then
        # create schema
        model=$(printf "import mongoose, { Document } from 'mongoose'\nimport { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';\n\n@Schema({timestamps:true, versionKey:false})\nexport class ${schema_name} extends Document{\n\n}\n\nexport const ${schema_name}Schema = SchemaFactory.createForClass(${schema_name})\n")
        echo "$model" > "$schema_file"

        echo "${schema_name} Schema created successfully"
    else
        echo "Schema '${schema_name}' already exists!"
    fi

fi

# create service
if [ "$create_option" -eq "$services" ]
then
    echo "Enter existing module name:"
    read module_name

    current_dir="$dir/src/modules/$module_name"

    # only create if folder does not exists
    if [ -d "$current_dir" ]
    then 

        echo "Enter Service file name:"
        read service_file_name

        service_file="$current_dir/services/$service_file_name.service.ts"

        echo "Enter Service class name:"
        read service_name

        # only create if file does not exists
        if [ ! -f "$service_file" ]
        then
            # create service
            service=$(printf "import { Injectable } from '@nestjs/common';\n\n@Injectable()\nexport class ${service_name}Service {}")
            echo "$service" > "$service_file"

            echo "${service_name} Service created successfully"
        else
            echo "Service '${service_name}' already exists!"
        fi

    else
        echo "$module_name does not exists!"
        exit 0
    fi

fi

# create controller
if [ "$create_option" -eq "$controllers" ]
then
    echo "Enter existing module name:"
    read module_name

    current_dir="$dir/src/modules/$module_name"

    # only create if folder does not exists
    if [ -d "$current_dir" ]
    then 

        echo "Enter Controller file name:"
        read controller_file_name

        controller_file="$current_dir/controllers/$controller_file_name.controller.ts"

        echo "Enter Controller class name:"
        read controller_name

        # only create if file does not exists
        if [ ! -f "$controller_file" ]
        then
            # create controller
            controller_s=$(printf "import { Controller, Get, Post, Put, Patch, Delete } from '@nestjs/common';\nimport { Body } from '@nestjs/common/decorators';\n@Controller()\nexport class ${controller_name}Controller {}")
            echo "$controller_s" > "$controller_file"

            echo "${controller_name} Controller created successfully"
        else
            echo "Controller '${controller_name}' already exists!"
        fi

    else
        echo "$module_name does not exists!"
        exit 0
    fi

fi

# create dto
if [ "$create_option" -eq "$dto" ]
then
    echo "Enter existing module name:"
    read module_name

    current_dir="$dir/src/modules/$module_name"

    # only create if folder does not exists
    if [ -d "$current_dir" ]
    then 

        echo "Enter DTO file name:"
        read dto_file_name

        dto_file="$current_dir/dtos/$dto_file_name.dto.ts"

        echo "Enter DTO class name:"
        read dto_name

        # only create if file does not exists
        if [ ! -f "$dto_file" ]
        then
            # create dto
            dto=$(printf "import { IsEmail, IsNotEmpty, IsString, MaxLength, MinLength } from 'class-validator';\n\nexport class ${dto_name}Dto{\n\n}")
            echo "$dto" > "$dto_file"

            echo "${dto_name} DTO created successfully"
        else
            echo "DTO '${dto_name}' already exists!"
        fi

    else
        echo "$module_name does not exists!"
        exit 0
    fi
fi