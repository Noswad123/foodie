package recipes

type Recipe struct {
	ID           int64   `json:"id"`
	Name         string  `json:"name"`
	TypeID       *int64  `json:"typeId,omitempty"`
	TypeName     *string `json:"typeName,omitempty"`
	Instructions *string `json:"instructions,omitempty"`
	PrepTime     *int32  `json:"prepTime,omitempty"`
	CookingTime  *int32  `json:"cookingTime,omitempty"`
	ServingSize  *int32  `json:"servingSize,omitempty"`
	CreatedAt    *string `json:"createdAt,omitempty"`
	UpdatedAt    *string `json:"updatedAt,omitempty"`
}
