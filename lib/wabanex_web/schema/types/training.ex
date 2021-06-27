defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, non_null(:string)
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4), description: "User that the training belongs to"
    field :start_date, non_null(:string), description: "Day that the training starts for the user"
    field :end_date, non_null(:string), description: "Day that the training ends for the user"
    field :exercises, list_of(:create_exercise_input), description: "Exercises for the training"
  end
end
