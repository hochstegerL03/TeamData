<template>
  <div class="container-fluid w-100">
    <form @submit.prevent="changePrj" class="w-100">
      <input
        type="text"
        class="form-control mb-4"
        id="prjName"
        placeholder="Name of the Project"
        v-model="futureProject.name"
        required
      />
      <input
        type="text"
        class="form-control mb-4"
        id="prjDescription"
        placeholder="Description of the Project"
        v-model="futureProject.description"
        required
      />
      <div class="row">
        <div class="col-md-6">
          <label for="prjStart">Start:</label>
          <input
            type="date"
            class="form-control mb-4"
            id="prjStart"
            placeholder="When will/did your project start?"
            v-model="futureProject.start"
            required
          />
        </div>

        <div class="col-md-6">
          <label for="prjEnd">End:</label>
          <input
            type="date"
            class="form-control mb-4"
            id="prjEnd"
            placeholder="When will your project end?"
            v-model="futureProject.deadline"
            required
          />
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="prjCustomer">Buyer:</label>
          <select
            class="form-control mb-4"
            id="prjCustomer"
            v-if="customers.length"
            required
            v-model="futureProject.customer_id"
          >
            <option
              v-for="customer in customers"
              :key="customer.customer_id"
              :value="customer.customer_id"
            >
              {{ `${customer.firstname} ${customer.lastname}` }}
            </option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="prjAdmin">Leader:</label>
          <select
            class="form-control mb-4"
            id="prjAdmin"
            v-if="admins.length"
            required
            v-model="futureProject.admin_id"
          >
            <option v-for="admin in admins" :key="admin.admin_id" :value="admin.admin_id">
              {{ `${admin.firstname} ${admin.lastname}` }}
            </option>
          </select>
        </div>
      </div>

      <button type="submit" class="btn btn-primary mt-3">Save</button>
    </form>
  </div>
</template>
<style></style>
<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
const admins = ref([]);
const customers = ref([]);
const futureProject = ref({
  name: '',
  description: '',
  start: new Date().toISOString().split('T')[0],
  deadline: new Date().toISOString().split('T')[0],
  admin_id: '',
  customer_id: '',
});

onMounted(async () => {
  customers.value = await getTargetCustomers();
  admins.value = await getTargetAdmins();
  console.log(admins.value);
  futureProject.value.admin_id = admins.value[0].admin_id;
  futureProject.value.customer_id = customers.value[0].customer_id;
});

const getTargetCustomers = async () => {
  let { data } = await axios.get('http://localhost:3000/customers');
  return data;
};
const getTargetAdmins = async () => {
  let { data } = await axios.get('http://localhost:3000/admins');
  return data;
};

const changePrj = async () => {
  try {
    if (new Date(futureProject.value.start) < new Date(futureProject.value.deadline)) {
      console.log(futureProject.value);
      await axios.post(`http://localhost:3000/projects`, {
        ...futureProject.value,
      });
      console.log('Success');
      alert('The Edit was successful!');
    } else throw new Error('Cannot end before it started');
  } catch (error) {
    console.log('Error');
    alert('It seems that something went wrong. Please try again.');
  }
};
</script>
