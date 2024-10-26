SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE TABLE public.project (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.resource (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    project_id uuid NOT NULL
);
CREATE TABLE public.scene (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    project_id uuid NOT NULL
);
CREATE TABLE public.scene_resource (
    scene_id uuid NOT NULL,
    resource_id uuid NOT NULL,
    project_id uuid NOT NULL
);
ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_id_project_id_key UNIQUE (id, project_id);
ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.scene
    ADD CONSTRAINT scene_id_project_id_key UNIQUE (id, project_id);
ALTER TABLE ONLY public.scene
    ADD CONSTRAINT scene_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.scene_resource
    ADD CONSTRAINT scene_resource_pkey PRIMARY KEY (scene_id, resource_id);
ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.scene
    ADD CONSTRAINT scene_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.scene_resource
    ADD CONSTRAINT scene_resource_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.scene_resource
    ADD CONSTRAINT scene_resource_resource_id_project_id_fkey FOREIGN KEY (resource_id, project_id) REFERENCES public.resource(id, project_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.scene_resource
    ADD CONSTRAINT scene_resource_scene_id_project_id_fkey FOREIGN KEY (scene_id, project_id) REFERENCES public.scene(id, project_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
