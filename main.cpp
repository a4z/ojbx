#define OBX_CPP_FILE
#include "objectbox.hpp"
#include "fbs/generated/objectbox-model.h"
#include "fbs/generated/tasklist.obx.hpp"

int main(int argc, char* args[]) {
  printf("Using ObjectBox version %s\n", obx_version_string());
    // create_obx_model() provided by objectbox-model.h
    // obx interface contents provided by objectbox.hpp
    obx::Store store(create_obx_model());
    obx::Box<Task> box(store);

    obx_id id = box.put({.text = "Buy milk"});  // Create
    std::unique_ptr<Task> task = box.get(id);   // Read
    if (task) {
        task->text += " & some bread";
        box.put(*task);                         // Update
        box.remove(id);                         // Delete
    }
    return 0;
}
