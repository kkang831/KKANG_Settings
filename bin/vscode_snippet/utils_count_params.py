def count_parameters(params):
    trainable_params = sum(p.numel() for p in params if p.requires_grad)
    all_params = sum(p.numel() for p in params)
    return trainable_params, all_params

# ---------------------------------------------------------------

from prettytable import PrettyTable
def count_parameters(model):
    table = PrettyTable(["Modules", "Parameters"])
    total_params = 0
    for name, parameter in model.named_parameters():
        if not parameter.requires_grad: 
            continue
        param = parameter.numel()
        table.add_row([name, param])
        total_params+=param
    print(table)
    print(f"Total Trainable Params: {total_params}")
    return total_params
count_parameters(model)
