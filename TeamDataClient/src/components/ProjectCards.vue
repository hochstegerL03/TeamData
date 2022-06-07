<template>
  <div>
    <div class="d-flex flex-wrap justify-content-center">
      <div
        class="card mb-3 mx-2"
        style="width: 20rem"
        v-for="project in projects"
        :key="project.project_id"
      >
        <div class="card-header">
          <p class="mt-1 mb-1">{{ project.name }}</p>
        </div>
        <div class="card-body">
          <div style="min-height: 10rem">
            <div
              v-if="project.description == `Not further details available.`"
              style="font-family: 'Syne Mono', monospace"
            >
              <p style="font-family: 'Syne Mono', monospace; margin: 0">
                <i>No further details available.</i>
              </p>
              <p><i>We are very sorry!</i></p>
            </div>
            <p v-else class="text-center truncatatfour">{{ project.description }}</p>
            <div class="collapse opacity-75" :id="`details${project.project_id}`">
              <div class="row">
                <div class="col-md-6">
                  <p>Start: {{ project.start }}</p>
                </div>
                <div class="col-md-6">
                  <p>End: {{ project.deadline }}</p>
                </div>
              </div>
              <div class="row" v-if="project.admin && project.customer">
                <div class="col-md-6">
                  <p style="margin: 0">Leader:</p>
                  <p>{{ project.admin }}</p>
                </div>
                <div class="col-md-6">
                  <p style="margin: 0">Buyer:</p>
                  <p>{{ project.customer }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="card-body">
          <button
            type="button"
            class="btn btn-primary ms-4"
            data-bs-toggle="collapse"
            :data-bs-target="`#details${project.project_id}`"
          >
            View More
          </button>
        </div>
        <div class="card-footer">
          <div class="row text-center">
            <div class="col-6">
              <button class="btn btn-primary" @click="deleteProject(project.project_id)">
                Delete
              </button>
            </div>
            <div class="col-6">
              <button
                type="button"
                class="btn btn-primary"
                @click="editTarget(project.project_id)"
                data-bs-toggle="modal"
                data-bs-target="#exampleModal"
              >
                Edit
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">{{ targetHeader }}</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="changePrj" style="text-align: left">
              <input
                type="text"
                class="form-control mb-4"
                id="prjName"
                placeholder="Name of the Project"
                v-model="targetProject.name"
                required
              />
              <input
                type="text"
                class="form-control mb-4"
                id="prjDescription"
                placeholder="Description of the Project"
                v-model="targetProject.description"
                required
              />
              <p for="prjStart">Start:</p>
              <input
                type="date"
                class="form-control mb-4"
                id="prjStart"
                placeholder="When will/did your project start?"
                v-model="targetProject.start"
                required
              />
              <p for="prjEnd">End:</p>
              <input
                type="date"
                class="form-control mb-4"
                id="prjEnd"
                placeholder="When will your project end?"
                v-model="targetProject.deadline"
                required
              />
              <p for="prjCustomer">Customer:</p>
              <select
                class="form-control mb-4"
                id="prjCustomer"
                v-if="targetCustomers[targetCustomers.length - 1]"
                required
                v-model="targetProject.customer_id"
              >
                <option v-for="customer in targetCustomers" :key="customer.customer_id" :value="customer.customer_id">
                  {{ customer.firstname }} {{ customer.lastname }}
                </option>
              </select>
              <p for="prjAdmin">Admin:</p>
              <select
                class="form-control mb-4"
                id="prjAdmin"
                v-if="targetAdmins[targetAdmins.length - 1]"
                required
                v-model="targetProject.admin_id"
              >
                <option v-for="admin in targetAdmins" :key="admin.admin_id" :value="admin.admin_id">
                  {{ admin.firstname }} {{ admin.lastname }}
                </option>
              </select>
              <button type="submit" class="btn btn-primary">Save</button>
            </form>
          </div>
          <div class="modal-footer"></div>
        </div>
      </div>
    </div>
  </div>
</template>
<style>
.btn-primary,
.btn-primary:active,
.btn-primary:visited {
  background-color: #48cae4 !important;
  border: #48cae4 !important;
  color: white !important;
}
.btn-primary:hover {
  background-color: #90e0ef !important;
  border: #90e0ef !important;
}
.card-body {
  background-color: #48cae4 !important;
  color: white;
}
.card {
  border: #ade8f4 1px solid !important ;
}
.card-header,
.card-footer {
  background-color: #48cae4 !important;
  color: white;
}
.card-header {
  border-bottom: #ade8f4 1px solid !important ;
}
.card-footer {
  border-top: #ade8f4 1px solid !important ;
}
body {
  background-color: #caf0f8 !important;
}
.rahmen {
  min-height: 100% !important;
  background-color: #ade8f4 !important;
}

.truncatatfour {
  -webkit-line-clamp: 4;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useProjectStore } from '@/stores/projectStore.js';
const projectStore = useProjectStore();
const targetProject = ref('');
const targetHeader = ref('');
const targetCustomers = ref('');
const targetAdmins = ref('');
const projects = ref();
onMounted(async () => {
  await getMain();
});

const getMain = async () => {
  await projectStore.getProjects();
  // await getAllFurtherData(projectStore.projects);
  console.log(projectStore.projects);
  projects.value = projectStore.projects;
};

const deleteProject = async (id) => {
  await axios.delete(`http://localhost:3000/projects/${id}`);
  await getMain();
};

const editTarget = async (id) => {
  targetProject.value = { ...projectStore.projects.find((elm) => elm.project_id === id) };
  targetHeader.value = targetProject.value.name;
  if (targetProject.value.description === 'Not further details available.') {
    targetProject.value.description = '';
  }
  targetCustomers.value = await getTargetCustomers(targetProject.value.customer_id);
  targetCustomers.value.push(await getTargetCustomer(targetProject.value.customer_id));
  targetAdmins.value = await getTargetAdmins(targetProject.value.admin_id);
  targetAdmins.value.push(await getTargetAdmin(targetProject.value.admin_id));
};
const getTargetCustomers = async (id) => {
  let { data } = await axios.get('http://localhost:3000/customers');
  data = data.filter((elm) => elm.customer_id !== id);
  return data;
};
const getTargetCustomer = async (id) => {
  const { data } = await axios.get(`http://localhost:3000/customers/${id}`);
  return data;
};
// const getAllFurtherData = async (projects) => {
//   let promises = [];
//   for (let project of projects) {
//     promises.push(showCustomer(project.customer_id));
//     promises.push(showAdmin(project.admin_id));
//   }
//   await Promise.all(promises);
//   // console.log(promises.length);
// };
// const showCustomer = async (id) => {
//   projectStore.projects[projectStore.projects.findIndex((elm) => elm.customer_id === id)].customer =
//     await getTargetCustomer(id);
//   // console.log(
//   //   projectStore.projects[projectStore.projects.findIndex((elm) => elm.customer_id === id)]
//   //     .customer,
//   // );
// };

// const showAdmin = async (id) => {
//   projectStore.projects[projectStore.projects.findIndex((elm) => elm.admin_id === id)].admin =
//     await getTargetAdmin(id);
//   // console.log(projects.value[projects.value.findIndex((elm) => elm.admin_id === id)].admin);
// };

const getTargetAdmins = async (id) => {
  let { data } = await axios.get('http://localhost:3000/admins');
  data = data.filter((elm) => elm.customer_id !== id);
  return data;
};
const getTargetAdmin = async (id) => {
  const { data } = await axios.get(`http://localhost:3000/admins/${id}`);
  return data;
};

const changePrj = async () => {
  try {
    if (new Date(targetProject.value.start) < new Date(targetProject.value.deadline)) {
      const { project_id, name, description, start, deadline, admin_id, customer_id } =
        targetProject.value;
      await axios.patch(`http://localhost:3000/projects/${project_id}`, {
        name,
        description,
        start,
        deadline,
        admin_id,
        customer_id,
      });
      console.log('Success');
      alert('The Edit was successful!');
    } else throw new Error('Cannot end before it started');
  } catch (error) {
    console.log('Error');
    alert('It seems that something went wrong. Please try again.');
  }
  await getMain();
};
</script>
